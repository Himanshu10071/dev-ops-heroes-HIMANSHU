import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;

public class HelloWorldServer {
    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress("0.0.0.0", 8080), 0);
        server.createContext("/", HelloWorldServer::handleRequest);
        server.start();
        System.out.println("Java app listening on port 8080");
    }

    private static void handleRequest(HttpExchange exchange) throws IOException {
        byte[] body = "<!doctype html><html><head><title>Java Hello World</title></head><body><h1>Hello World from Java</h1></body></html>"
                .getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", "text/html; charset=utf-8");
        exchange.sendResponseHeaders(200, body.length);
        try (var output = exchange.getResponseBody()) {
            output.write(body);
        }
    }
}