package store.momo;


import okhttp3.*;
import okio.Buffer;

import java.io.IOException;

public class Execute {

    OkHttpClient client = new OkHttpClient();

    public HttpResponse sendToMoMo(String endpoint, String payload) {

        try {

            HttpRequest httpRequest = new HttpRequest("POST", endpoint, payload, "application/json");

            okhttp3.Request request = createRequest(httpRequest);


            okhttp3.Response result = client.newCall(request).execute();
            HttpResponse response = new HttpResponse(result.code(), result.body().string(), result.headers());


            return response;
        } catch (Exception e) {
        }

        return null;
    }

    public static okhttp3.Request createRequest(HttpRequest request) {
        RequestBody body = RequestBody.create(MediaType.get(request.getContentType()), request.getPayload());
        return new okhttp3.Request.Builder()
                .method(request.getMethod(), body)
                .url(request.getEndpoint())
                .build();
    }

    public String getBodyAsString(okhttp3.Request request) throws IOException {
        Buffer buffer = new Buffer();
        RequestBody body = request.body();
        body.writeTo(buffer);
        return buffer.readUtf8();
    }
}
