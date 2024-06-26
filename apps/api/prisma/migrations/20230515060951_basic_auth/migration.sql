-- AlterTable
ALTER TABLE "Application" ADD COLUMN "basicAuthPw" TEXT;
ALTER TABLE "Application" ADD COLUMN "basicAuthUser" TEXT;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ApplicationSettings" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "applicationId" TEXT NOT NULL,
    "dualCerts" BOOLEAN NOT NULL DEFAULT false,
    "debug" BOOLEAN NOT NULL DEFAULT false,
    "previews" BOOLEAN NOT NULL DEFAULT false,
    "autodeploy" BOOLEAN NOT NULL DEFAULT true,
    "isBot" BOOLEAN NOT NULL DEFAULT false,
    "isPublicRepository" BOOLEAN NOT NULL DEFAULT false,
    "isDBBranching" BOOLEAN NOT NULL DEFAULT false,
    "isCustomSSL" BOOLEAN NOT NULL DEFAULT false,
    "isHttp2" BOOLEAN NOT NULL DEFAULT false,
    "basicAuth" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "ApplicationSettings_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ApplicationSettings" ("applicationId", "autodeploy", "createdAt", "debug", "dualCerts", "id", "isBot", "isCustomSSL", "isDBBranching", "isHttp2", "isPublicRepository", "previews", "updatedAt") SELECT "applicationId", "autodeploy", "createdAt", "debug", "dualCerts", "id", "isBot", "isCustomSSL", "isDBBranching", "isHttp2", "isPublicRepository", "previews", "updatedAt" FROM "ApplicationSettings";
DROP TABLE "ApplicationSettings";
ALTER TABLE "new_ApplicationSettings" RENAME TO "ApplicationSettings";
CREATE UNIQUE INDEX "ApplicationSettings_applicationId_key" ON "ApplicationSettings"("applicationId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
