package com.blog.servlet;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;


@WebServlet("/GrammarCheckServlet")
public class GrammarCheckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        try(PrintWriter out = resp.getWriter()){
            //fetch content from the UI
            String content = req.getParameter("pContent");

            System.out.println(content);

            //prepare the JSON payload for the LLM request
            String jsonPayload = String.format(
                    "{\"prompt\": \"Please rewrite the following text for clarity, grammar, and style, while preserving its meaning. Do not add personal opinions, disclaimers, or extra commentary. Only return the improved text and nothing else. Here is the original text:  %s\", \"model\": \"llama3.2\"}",
                    content.replace("\"", "\\\""));
            System.out.println(jsonPayload);

            //Set up the HTTP connection to the ollama server
            URL url = new URL("http://localhost:11434/api/generate");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setDoOutput(true);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");

            //Send the JSON payload
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonPayload.getBytes("UTF-8");
                os.write(input, 0, input.length);
            }

            //Read the response from the LLM
            StringBuilder responseContent = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    responseContent.append(responseLine.trim());
                }
            }

            // The responseContent now holds concatenated JSON objects.
            String fixedJson = responseContent.toString().replaceAll("}\\{", "}\n{");
            String[] jsonLines = fixedJson.split("\\n");

            //Parse each line and collect "response" fields
            StringBuilder finalOutput = new StringBuilder();
            for (String line : jsonLines) {
                if (line.trim().isEmpty()) {
                    continue;
                }

                JsonObject jsonObj = JsonParser.parseString(line).getAsJsonObject();
                if (jsonObj.has("response")) {
                    String chunk = jsonObj.get("response").getAsString();
                    // Append with a space or newline in between if you like
                    // --- KEY LOGIC FOR FIXING WORD-SPLITTING ---
                    // 1) Trim just to be safe; often the chunk includes leading/trailing spaces.
                    chunk = chunk.trim();

                    // 2) Decide whether to add a space before this chunk,
                    //    depending on how finalOutput ends and how chunk begins.
                    if (finalOutput.length() > 0) {
                        char lastChar = finalOutput.charAt(finalOutput.length() - 1);
                        if (Character.isLetterOrDigit(lastChar) && !chunk.isEmpty()) {
                            // If the chunk does NOT begin with punctuation, add a space
                            // unless chunk starts with punctuation like ',', '.', etc.
                            char firstChunkChar = chunk.charAt(0);
                            if (Character.isLetterOrDigit(firstChunkChar)) {
                                finalOutput.append(" ");
                            }
                        }
                    }

                    // 3) Append the chunk
                    finalOutput.append(chunk);
                }
            }

            //return the combined text
            String combinedResponses = finalOutput.toString().replaceAll("\\s+", " ").trim();
            System.out.println("Combined LLM Response:\n" + combinedResponses);

            // Create a JSON response for the frontend
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", "success");
            jsonResponse.addProperty("enhancedContent", combinedResponses);

            System.out.println(jsonResponse);

            // Send the JSON response back to the frontend
            out.println(jsonResponse.toString());
        }
    }
}
