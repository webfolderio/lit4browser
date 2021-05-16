cd examples
cd todo
cmd /c tsc
start "" "http://localhost:8000/todo.html"
python -m http.server