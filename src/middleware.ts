import { NextResponse } from "next/server";

export default async () => {
  return NextResponse.next();
};

export const config = {
  matcher: [
    "/",
    "/((?!api|robots.txt|sitemap|static|data|image|assets|favicon.ico|sw.js|.well-known/apple-developer-merchantid-domain-association).*)",
  ],
};
