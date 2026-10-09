;; task 14 file_read — expected output: 2389704704
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t14-file-read    run: <root>/tools/nodejs/node.exe prog.js
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
;; note: this is a change from sources/clojure/14_file_read.clj. ClojureScript has no file system of
;;       its own -- there is no java.io.FileInputStream on this target -- so the file is reached
;;       through node's fs module with (js/require "fs"), which the Closure compiler emits as a
;;       require("fs") call inside the node module. openSync/readSync/closeSync are the same
;;       open/read/close sequence, in the same 1 MiB chunks, and the running total is the same sum
;;       of the same bytes reduced mod 2^32. node has no text mode, so no BOM is stripped or added.
;; note: the JVM row's `(set! *unchecked-math* true)`, its ^long hints and its unchecked-* calls are
;;       JVM primitive machinery and are dropped here; see 01_branches.cljs for why. The chunk
;;       buffer is a Uint8Array, whose elements are already unsigned, so the (bit-and b 0xFF) the
;;       JVM row needs for its signed bytes is not needed.
;; note: the reduction mod 2^32 keeps the running total inside the 2^53 range where a double is
;;       exact; the JVM row does the same, in the same place, per chunk.
;; Reads data.bin (52428800 bytes) from the working directory in 1 MiB chunks.

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (let [fs (js/require "fs")
        chunk (* 1024 1024)
        buf (js/Uint8Array. chunk)
        fd (.openSync fs "data.bin" "r")
        total (loop [total 0]
                (let [n (.readSync fs fd buf 0 chunk nil)]
                  (if (pos? n)
                    (recur (rem (loop [i 0 t total]
                                  (if (< i n)
                                    (recur (inc i) (+ t (aget buf i)))
                                    t))
                                4294967296))
                    total)))]
    (.closeSync fs fd)
    (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
    (println total)))

(-main)
