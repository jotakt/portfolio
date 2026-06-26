import { serveDir, serveFile } from "@std/http/file-server";

const STATIC_DIR = "./static";
const PORT = 8000;

Deno.serve({ port:PORT }, async (req) => {
    const url = new URL(req.url);

    if(url.pathname.startsWith("/api")) {
        return Response.json(
            {
                ok: false,
                error: "Endpoint não encontrado.",
            },
            {
                status: 404
            }
        );
    }

    const staticResponse = await serveDir(req, {
        fsRoot: STATIC_DIR,
        urlRoot: "",
        showDirListing: false,
    });

    if (staticResponse.status !== 404) {
        return staticResponse;
    }

    return serveFile(req, `${STATIC_DIR}/index.html`);
});

console.log(`Servidor rodando em http://localhost:${PORT}`);