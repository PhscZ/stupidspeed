// task 07 string_append -- expected output: 1000000
// build: clang -fobjc-runtime=gnustep-2.2 -O2 -o prog 07_string_append.m -lobjc -lgnustep-base    run: ./prog
// Each append allocates a new buffer and copies the complete prior text, which is the
// quadratic copy the task measures. The bytes are held in a plain malloc'd buffer rather
// than an NSString: stringByAppendingString: returns an autoreleased object, so a million
// intermediate strings would stay alive in the enclosing autorelease pool and the run
// would exhaust memory long before the loop finished. The C row's realloc plus strcat is
// the same shape.
#import <Foundation/Foundation.h>
#include <stdlib.h>
#include <string.h>
int main(void) { @autoreleasepool {
    char *text = malloc(1);
    size_t length = 0;
    text[0] = '\0';
    for (int i = 0; i < 1000000; i++) {
        char *next = malloc(length + 2);
        memcpy(next, text, length);
        next[length] = 'x';
        next[length + 1] = '\0';
        free(text);
        text = next;
        length++;
    }
    printf("%lu\n", (unsigned long)length);
    free(text);
} return 0; }
