from flask import Flask, request, render_template
import subprocess
import os
import signal

app = Flask(__name__)

# Specify the directory where your .txt files are located
txt_directory = './fuktermux/resources/reports'

def shutdown_server():
    os.kill(os.getpid(), signal.SIGINT)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        command = request.form.get('command')
        if command == 'list_txt_files':
            try:
                txt_files = [f for f in os.listdir(txt_directory)]
                return render_template('index.html', txt_files=txt_files)
            except Exception as e:
                return str(e)
        elif command.startswith('cat_txt_file'):
            try:
                file_name = command.split(':')[-1]
                file_path = os.path.join(txt_directory, file_name)
                with open(file_path, 'r') as file:
                    file_contents = file.read()
                return render_template('index.html', file_contents=file_contents, file_name=file_name)
            except Exception as e:
                return str(e)
        elif command.startswith('delete_txt_file'):
            try:
                file_name = command.split(':')[-1]
                file_path = os.path.join(txt_directory, file_name)
                os.remove(file_path)
                return 'File deleted successfully.'
            except Exception as e:
                return str(e)
        elif command == 'shutdown_server':
            try:
                shutdown_server()
                return 'Server shut down successfully.'
            except Exception as e:
                return str(e)
    return render_template('index.html', txt_files=None, file_contents=None, file_name=None)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
