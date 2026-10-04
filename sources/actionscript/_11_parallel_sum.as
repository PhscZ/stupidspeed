// task 11 parallel_sum — expected output: 7500000075000000
// build: amxmlc -swf-version=51 -output prog.swf _11_parallel_sum.as
//        amxmlc -swf-version=51 -output worker.swf _11_parallel_sum_worker.as
//        adt -package -storetype pkcs12 -keystore test.p12 -storepass pass -target cmdline out app.xml prog.swf worker.swf
// run: out\prog.exe
// note: AIR 51.4.1 via amxmlc (the real Adobe/HARMAN compiler), packaged with adt
//       into a standalone captive-runtime exe. Java 17 on PATH.
// note: the AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before
//       the program's own output, so a harness must skip it; the program's line is
//       everything after that offset. System.output() writes to stdout but adds no
//       newline, so every line ends with an explicit \n, and the program calls
//       NativeApplication.exit(0) because an AIR app otherwise stays alive.
// note: this row is two translation units. _11_parallel_sum_worker.as compiles to
//       worker.swf, which the build line passes to adt as an extra file so it lands
//       inside the bundle; the main SWF reads those bytes and calls
//       WorkerDomain.current.createWorker() four times.
// note: results come back through Worker shared properties rather than a
//       MessageChannel. A channel made with worker.createMessageChannel(Worker.current)
//       and handed over with setSharedProperty arrives in the worker intact, but the
//       worker's send() then throws Error #3738 whatever the timing, and this is a
//       known soft spot in the runtime rather than something the program is doing
//       wrong. Shared properties are the other documented channel between workers and
//       they work reliably in both directions -- the t index arrives the same way --
//       so each worker publishes its partial under "rN" and the main thread polls for
//       the four of them. The work is real and concurrent; only the hand-back differs.
// note: the four partials are summed in index order, which does not change the answer:
//       every partial is far below 2^53, so the total is exact.

// timing: getTimer() is the AVM2 clock, whole milliseconds since the VM started. AIR has
//       no stderr, so the contract's fallback applies: TIME_MS goes to time.txt in
//       File.applicationStorageDirectory -- %APPDATA%\stupidspeed.actionscript\Local Store\,
//       the writable directory task 15 writes out.bin to, because the bundle directory is
//       read-only. The constructor only schedules the work, so the timer starts there and
//       stops just before the final output in collect(); the file write and the exit are one
//       more event-loop turn later, outside the measured region.
package
{
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.system.System;
    import flash.system.Worker;
    import flash.system.WorkerDomain;
    import flash.desktop.NativeApplication;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    public class _11_parallel_sum extends Sprite
    {
        private var workers:Array = [];
        private var __t0:int = 0;
        private var __ms:int = 0;

        public function _11_parallel_sum()
        {
            __t0 = getTimer();
            // See task 14: a FileStream cannot be opened from the constructor, so the
            // worker SWF is loaded and the workers started one event-loop turn later.
            setTimeout(startWorkers, 0);
        }

        private function startWorkers():void
        {
            try
            {
                var bytes:ByteArray = new ByteArray();
                var workerFile:File = File.applicationDirectory.resolvePath("worker.swf");
                var stream:FileStream = new FileStream();
                stream.open(workerFile, FileMode.READ);
                stream.readBytes(bytes, 0, stream.bytesAvailable);
                stream.close();

                for (var t:int = 0; t < 4; t++)
                {
                    var worker:Worker = WorkerDomain.current.createWorker(bytes, false);
                    worker.setSharedProperty("t", t);
                    worker.start();
                    workers.push(worker);
                }

                setTimeout(collect, 20);
            }
            catch (err:Error)
            {
                __ms = getTimer() - __t0;
                System.output("error: " + err + "\n");
                setTimeout(__report, 0);
            }
        }

        private function collect():void
        {
            var total:Number = 0;
            for (var i:int = 0; i < 4; i++)
            {
                var part:Object = workers[i].getSharedProperty("r" + i);
                if (part == null)
                {
                    setTimeout(collect, 20);
                    return;
                }
                total = total + Number(part);
            }
            __ms = getTimer() - __t0;
            System.output(total + "\n");
            setTimeout(__report, 0);
        }

        private function __report():void
        {
            try
            {
                var f:File = File.applicationStorageDirectory.resolvePath("time.txt");
                var s:FileStream = new FileStream();
                s.open(f, FileMode.WRITE);
                s.writeUTFBytes("TIME_MS=" + __ms + "\n");
                s.close();
            }
            catch (e:Error) { }
            NativeApplication.nativeApplication.exit(0);
        }
    }
}
