// task 11 parallel_sum — worker translation unit, compiled to worker.swf
// build: amxmlc -swf-version=51 -output worker.swf _11_parallel_sum_worker.as
// note: the AIR worker entry point. AIR runs the class named in the SWF's main
//       timeline, so this class does its range in the constructor.
// note: Workers share no memory, so t arrives as a shared property set by the main
//       SWF before start(). The partial goes back the same way, under "rN", because a
//       MessageChannel's send() throws Error #3738 from inside a worker -- see the
//       note in _11_parallel_sum.as.
// note: the loop is exactly the main thread's work split four ways: worker t covers
//       [t*25000000, (t+1)*25000000). The accumulator is a Number because 3*i for the
//       last few indices pushes the running total past 2^31, where an AS3 int would
//       silently wrap.

package
{
    import flash.display.Sprite;
    import flash.system.Worker;

    public class _11_parallel_sum_worker extends Sprite
    {
        public function _11_parallel_sum_worker()
        {
            var t:Number = Number(Worker.current.getSharedProperty("t"));

            var start:Number = t * 25000000;
            var end:Number = (t + 1) * 25000000;

            var acc:Number = 0;
            for (var i:Number = start; i < end; i++)
            {
                switch (i % 4)
                {
                    case 0: acc = acc + 1; break;
                    case 1: acc = acc + i; break;
                    case 2: acc = acc + 2 * i; break;
                    case 3: acc = acc + 3 * i; break;
                }
            }

            Worker.current.setSharedProperty("r" + t, acc);
        }
    }
}
