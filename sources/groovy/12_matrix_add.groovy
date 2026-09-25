// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: groovy 12_matrix_add.groovy
// Three 1000x1000 long[][] arrays, 24 MB together, too big to sit in cache.

int n = 1000
long[][] a = new long[n][n]
long[][] b = new long[n][n]
long[][] c = new long[n][n]

for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        a[i][j] = i + j
        b[i][j] = i - j
    }
}

for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        c[i][j] = a[i][j] + b[i][j]
    }
}

long total = 0
for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        total += c[i][j]
    }
}

println total
