CREATE DATABASE "bankAccounts";

CREATE TABLE "customers" (
    "id" SERIAL PRIMARY KEY,
    "fullName" VARCHAR(60) NOT NULL,
    "cpf" INTEGER NOT NULL UNIQUE,
    "email" VARCHAR(60) NOT NULL,
    "password" VARCHAR(60) NOT NULL,
)

CREATE TABLE "states" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(60) NOT NULL UNIQUE,
);

CREATE TABLE "cities" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(60) NOT NULL UNIQUE,
    "stateId" INTEGER NOT NULL REFERENCES "states"("id"),
);

CREATE TABLE "customerAddresses" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
    "street" VARCHAR(60) NOT NULL,
    "number" INTEGER NOT NULL,
    "complement" VARCHAR(40),
    "postalCode" INTEGER NOT NULL UNIQUE,
    "cityId" INTEGER NOT NULL REFERENCES "cities"("id"),
);

CREATE TABLE "customersPhones" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
    "number" INTEGER NOT NULL,
    "type" ENUM("mobile", "landline"),
);

CREATE TABLE "bankAccount" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
    "accountNumber" INTEGER NOT NULL UNIQUE,
    "agency" INTEGER NOT NULL,
    "openDate" DATE DEFAULT CURDATE(),
    "closeDate" DATE,
);

CREATE TABLE "transactions" (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
    "amount" REAL NOT NULL,
    "type" ENUM("deposit", "withdraw"),
    "time" TIMESTAMP DEFAULT NOW(),
    "description" TEXT,
    "cancelled" BOOLEAN,
);

CREATE TABLE "creditCards" (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
    "name" VARCHAR(60) NOT NULL,
    "number" INTEGER NOT NULL UNIQUE,
    "securityCode" INTEGER NOT NULL,
    "expirationMonth" INTEGER NOT NULL,
    "expirationYear" INTEGER NOT NULL,
    "password" VARCHAR(60) NOT NULL,
    "limit" INTEGER NOT NULL,
)