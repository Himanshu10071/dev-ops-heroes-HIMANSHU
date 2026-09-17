from http.server import BaseHTTPRequestHandler, HTTPServer


class HelloWorldHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = b"<!doctype html><html><head><title>Python Hello World</title></head><body><h1>Hello World from Python</h1></body></html>"
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format_string, *args):
        return


HTTPServer(("0.0.0.0", 8000), HelloWorldHandler).serve_forever()