;; task 11 parallel_sum — expected output: 7500000075000000
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 11_parallel_sum.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: babashka has no threads at all — it is a single-threaded native image, and its
;;       `future` runs on one thread, so four futures would serialise. This is four child
;;       processes instead: the parent starts four copies of this same file with
;;       babashka.process, each given a worker index as its argument, and each child computes
;;       one quarter of task 02's range and prints its partial sum. The parent derefs all four
;;       processes, which joins them, then adds the partials. That is the same mechanism the
;;       VBScript row uses with WScript.Shell.Exec, the R row with PSOCK and the COBOL row
;;       with CBL_GC_FORK, and unlike R's and COBOL's it is real parallelism on Windows.
;; note: each worker owns a fixed quarter, so which one finishes first cannot change the
;;       answer. The child's stdout is captured with :out :string and its stderr with
;;       :err :string, so nothing a child writes can reach the parent's stderr.
;; note: the parent passes its own script path, taken from the babashka.file system property,
;;       to the children, so it can be started from any working directory. The interpreter
;;       path is resolved at run time: first C:\stupidspeed\tools\babashka\bb.exe, then
;;       whatever "bb.exe" resolves to on PATH.

(require '[babashka.process :as p])
(require '[babashka.fs :as fs])
(require '[clojure.string :as str])

(set! *unchecked-math* true)

(def ^:const SPAN 25000000)

;; One quarter of task 02's work, exactly the same switch on (rem i 4).
(defn work ^long [^long t]
  (let [start (unchecked-multiply t (long SPAN))
        end (unchecked-add start (long SPAN))]
    (loop [i start acc (long 0)]
      (if (< i end)
        (recur (inc i)
               (unchecked-add acc
                              (case (int (rem i 4))
                                0 1
                                1 i
                                2 (unchecked-multiply 2 i)
                                3 (unchecked-multiply 3 i))))
        acc))))

(defn bb-exe []
  (let [candidates ["C:\\stupidspeed\\tools\\babashka\\bb.exe"
                    (str (fs/which "bb.exe"))
                    "bb.exe"]]
    (or (some (fn [c] (when (and (seq c) (fs/exists? c)) (str c))) candidates)
        "bb.exe")))

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [exe (bb-exe)
        script (System/getProperty "babashka.file")
        procs (mapv (fn [t] (p/process [exe script (str t)] {:out :string :err :string}))
                    (range 4))
        partials (mapv (fn [pr] (Long/parseLong (str/trim (:out @pr)))) procs)
        total (reduce unchecked-add (long 0) partials)]
    (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
    (println total)))

(if (seq *command-line-args*)
  ;; child: compute one quarter and print only that number on stdout
  (println (work (Long/parseLong (first *command-line-args*))))
  (-main))
