import subprocess, re, os, shutil, sys

D = r"C:\stupidspeed\exec\php"
# ZTS build: task 11 needs the PECL `parallel` extension, which requires ZTS, and the
# stock tools\php\php.exe is NTS. tools\php-zts\ is the same PHP 8.5.11 with
# php_parallel.dll installed and extension_dir/extension=parallel in its php.ini, so
# both toolchains of this row use it and differ only in the JIT flags.
PHP = r"C:\stupidspeed\tools\php-zts\php.exe"
DATA = r"C:\stupidspeed\data.bin"

tasks = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]
exp = {"01_branches": "33333334 13333333 7619048 45714285", "02_switch_case": "7500000075000000",
       "03_func_sum": "100000000", "04_array_sum": "499999500000", "05_alloc_churn": "1274991808",
       "06_char_count": "10000000", "07_string_append": "250000", "08_average": "0.498046875",
       "09_fib_recursive": "102334155", "10_pi": "4470", "11_parallel_sum": "7500000075000000",
       "12_matrix_add": "999000000", "13_matrix_mul": "599995000", "14_file_read": "2389704704",
       "15_file_write": "52428800"}

# toolchain -> extra php args (from each task's header run: line)
chains = [("zend", []),
          ("zend-jit", ["-d", "opcache.enable_cli=1", "-d", "opcache.jit=tracing",
                        "-d", "opcache.jit_buffer_size=64M"])]

# The zend+jit header must actually turn the JIT on: PHP 8.5 defaults opcache.jit to
# `disable`, so jit_buffer_size alone leaves JIT off. Probe it on one task per run.
JIT_PROBE = ('register_shutdown_function(function(){$s=opcache_get_status(false);'
             'fwrite(STDERR,"JIT_ON=".var_export($s["jit"]["on"]??null,true)."\\n");});'
             'require "%s";')

TIMEOUT = 600

for name, extra in chains:
    td = os.path.join(D, name)
    ok = 0
    fails = []
    print("### %s" % name, flush=True)
    if extra:
        probe = subprocess.run([PHP] + extra + ["-r", JIT_PROBE % "04_array_sum.php"],
                               capture_output=True, text=True,
                               cwd=os.path.join(td, "04_array_sum"), timeout=TIMEOUT)
        m = re.search(r"JIT_ON=(\w+)", probe.stderr)
        print("JIT_ON=%s" % (m.group(1) if m else "unknown"), flush=True)
    for t in tasks:
        d = os.path.join(td, t)
        src = os.path.join(d, t + ".php")
        if not os.path.exists(src):
            fails.append(t)
            print("%-18s FAIL missing %s (run build_all.bat)" % (t, src), flush=True)
            continue
        if t in ("14_file_read", "15_file_write"):
            if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
        if t == "15_file_write":
            op = os.path.join(d, "out.bin")
            if os.path.exists(op):
                os.remove(op)
        try:
            r = subprocess.run([PHP] + extra + [t + ".php"], capture_output=True, text=True,
                               cwd=d, timeout=TIMEOUT)
            out = r.stdout.strip()
            tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
            good = (out == exp[t]) and (tm is not None)
            if t == "15_file_write":
                good = good and os.path.exists(os.path.join(d, "out.bin"))
            if good:
                ok += 1
                print("%-18s OK TIME_MS=%s" % (t, tm.group(1)), flush=True)
            else:
                fails.append(t)
                why = []
                if out != exp[t]:
                    why.append("stdout expected %r got %r" % (exp[t], out[:80]))
                if tm is None:
                    why.append("no TIME_MS on stderr")
                if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
                    why.append("out.bin missing")
                print("%-18s FAIL %s" % (t, "; ".join(why)), flush=True)
                tail = "\n".join((r.stderr or "").strip().splitlines()[-6:])
                if tail:
                    print("    stderr tail: %s" % tail.replace("\n", "\n    "), flush=True)
        except subprocess.TimeoutExpired:
            fails.append(t)
            print("%-18s FAIL timeout after %ss" % (t, TIMEOUT), flush=True)
    print("PHP %s PASS %d/15" % (name, ok), flush=True)
    if fails:
        print("PHP %s FAILED: %s" % (name, " ".join(fails)), flush=True)
