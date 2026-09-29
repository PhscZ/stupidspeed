# task 11 parallel_sum — expected output: 7500000075000000
# build: none (interpreted)    run: octave-cli -qf 11_parallel_sum.m
#
# note: Octave has no threads for m-code and no shared memory between processes,
# so this is four child processes rather than four threads. parfor is accepted by
# the parser but is a mere synonym of for, and fork() is compiled out on native
# Windows ("not implemented in native windows"), so the benchmark's
# "pass, but with processes rather than threads" category applies, as it does to
# the R, VBScript and COBOL rows.
# note: the parent starts four copies of this same file with popen, each one
# given its worker index through the environment, and each child computes one
# fixed quarter of task 02's range and prints its partial sum. All four children
# are started before any output is read, so they run concurrently; each writes
# one short line, so the pipe buffer cannot deadlock. Reading a child's stdout
# blocks until that child exits, which is the join, and the parent adds the four
# partials. This is the VBScript row's structure (sources/vbscript/
# 11_parallel_sum.vbs).
# note: arguments placed after the script name do not become variables in the
# script, and --eval and a script file are mutually exclusive, so the worker
# index travels in the environment: each child inherits the snapshot the parent
# set immediately before spawning it.
# note: the worker helper is defined above the driver, in this same file, because
# Octave defines a script's local functions only when their definition is
# executed. The leading 1; keeps the first token of the file from being
# `function`.
# note: each worker owns a fixed quarter, so which one finishes first cannot
# change the answer. The total 7500000075000000 is below 2^53, so the four double
# partials add exactly.

1;

function acc = work_range_(t)
  acc = 0;
  for i = t * 25000000:(t + 1) * 25000000 - 1
    switch mod(i, 4)
      case 0
        acc = acc + 1;
      case 1
        acc = acc + i;
      case 2
        acc = acc + 2 * i;
      case 3
        acc = acc + 3 * i;
    end
  end
end

worker = getenv('OCTAVE_WORKER');
if numel(worker) > 0
  printf("%.0f\n", work_range_(str2double(worker)));
else
  exe = fullfile(OCTAVE_EXEC_HOME(), 'bin', 'octave-cli.exe');
  cmd = ['"' exe '" -qf 11_parallel_sum.m'];

  handles = zeros(1, 4);
  for t = 0:3
    setenv('OCTAVE_WORKER', num2str(t));
    handles(t + 1) = popen(cmd, 'r');
  end

  total = 0;
  for t = 0:3
    line = fgetl(handles(t + 1));
    total = total + str2double(line);
    pclose(handles(t + 1));
  end
  printf("%.0f\n", total);
end
