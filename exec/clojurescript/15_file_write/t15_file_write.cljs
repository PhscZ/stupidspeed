;; task 15 file_write — expected output: 52428800
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t15-file-write    run: <root>/tools/nodejs/node.exe prog.js
;; note: the ClojureScript row; the JVM sibling is sources/clojure/. Built with the ClojureScript
;;       release jar (ClojureScript 1.11.132, tools/clojurescript/cljs.jar -- it bundles Clojure,
;;       the Closure compiler and cljs/core.cljs) and run under tools/nodejs/node.exe (node 22.11.0).
;;       Unlike the JVM row this one has a build step: cljs.main compiles the .cljs to JavaScript
;;       ahead of time, so the compile time is not inside the measured number. The classpath's `.`
;;       is the cell's own directory, which is where the .cljs source sits.
;; note: ClojureScript requires the namespace to correspond to the file name, so each file carries an
;;       `(ns ...)` header named after itself and the file is named to match: t01_branches.cljs holds
;;       (ns t01-branches), the `t` because a namespace symbol cannot begin with a digit. That
;;       single-segment namespace is what the :single-segment-namespace warning is silenced for. The
;;       file ends with a plain `(-main)` call, the same shape the JVM row uses. The `tNN_` prefix is
;;       ClojureScript's rule, not this row's; the JVM row's files are plain 01_branches.clj.
;; note: this is a change from sources/clojure/15_file_write.clj. ClojureScript has no file system of
;;       its own -- there is no java.io.FileOutputStream on this target -- so the file is reached
;;       through node's fs module with (js/require "fs"), which the Closure compiler emits as a
;;       require("fs") call inside the node module. openSync/writeSync/fsyncSync/closeSync write the
;;       same 1 MiB pattern 50 times and commit it the way getFD().sync() does; fsyncSync is a real
;;       fsync on the same fd. openSync's "w" flag is binary in node -- there is no text mode, so no
;;       BOM and no newline translation can be added to the bytes.
;; note: the JVM row's `(set! *unchecked-math* true)`, its ^long hints and its unchecked-* calls are
;;       JVM primitive machinery and are dropped here; see 01_branches.cljs for why. The pattern
;;       buffer is a Uint8Array, which stores (rem i 256) as the same unsigned byte the JVM row's
;;       unchecked-byte stores.
;; Writes out.bin as 50 chunks of the 1 MiB pattern 0,1,2,...,255 repeated 4096 times.

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (let [fs (js/require "fs")
        len (* 1024 1024)
        buf (js/Uint8Array. len)]
    (dotimes [i len]
      (aset buf i (rem i 256)))
    (let [fd (.openSync fs "out.bin" "w")]
      (dotimes [i 50]
        (.writeSync fs fd buf 0 len))
      (.fsyncSync fs fd)
      (.closeSync fs fd))
    (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
    (println (* 50 len))))

(-main)
