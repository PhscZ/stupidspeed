// task 13 matrix_mul — expected output: 599995000
// build: none (interpreted)    run: groovy 13_matrix_mul.groovy
// Plain triple loop, no tricks: the innermost loop walks B down a column, which is
// the cache-hostile order the task asks for.

int n = 500
long[][] a = new long[n][n]
long[][] b = new long[n][n]
long[][] c = new long[n][n]

for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        a[i][j] = (i + j) % 7
        b[i][j] = (i * j) % 5
    }
}

for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        long sum = 0
        for (int k = 0; k < n; k++) {
            sum += a[i][k] * b[k][j]
        }
        c[i][j] = sum
    }
}

long total = 0
for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        total += c[i][j]
    }
}

println total
