# task 07 string_append — expected output: 250000
# build: none (interpreted)    run: tools/dotnet8/dotnet.exe tools/ironpython/net8.0/ipy.dll 07_string_append.py
# note: .NET strings are immutable, so every += allocates a new string and copies the old one; the loop
#       is quadratic in the final length. That is the point of the task, not an accident.

text = ''
for _ in range(250000):
    text += 'x'

print(len(text))
