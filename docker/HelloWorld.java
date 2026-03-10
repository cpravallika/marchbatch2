package docker;

import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

public class HelloWorld {
    public static void main(String[] args) throws IOException {
        // Create HTTP server on port 80
        HttpServer server = HttpServer.create(new InetSocketAddress(80), 0);

        // Create context for root path
        server.createContext("/", new HelloHandler());

        // Start the server
        server.setExecutor(null); // Use default executor
        server.start();

        System.out.println("Server started on port 80");
    }

    static class HelloHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String response = "Hello, World!\n" +
                              "Welcome to Java programming.\n" +
                              "Java Version: " + System.getProperty("java.version") + "\n" +
                              "Operating System: " + System.getProperty("os.name") + "\n" +
                              "Sum of 10 and 20 is: " + calculateSum(10, 20) + "\n";

            exchange.sendResponseHeaders(200, response.length());
            OutputStream os = exchange.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }
    
    public static int calculateSum(int a, int b) {
        return a + b;
    }
}
