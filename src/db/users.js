/**
 * Stub implementation of database methods related to accessing
 * stored users.
 *
 * NOTE: this is a stub implementation meant to demonstrate how
 * the rest of the application can work.
 */

import { hashPassword, comparePassword } from "../lib/crypto";

// This is where the users are stored. In a real app, use an actual
// database, not just a varaible
let users = [];
let currentId = 0;

const PUBLIC_FIELDS = ["id", "name"];

/**
 * Finds a user based on an id/password pair. If user doesn't exist
 * or password doesn't match, this function returns null.
 * @param {string} id user's id
 * @param {string} password user's password
 */
export async function getUserByCredentials(id, password) {
  const user = users.find(user => user.id === id);
  if (!user) {
    return null;
  }

  if (await comparePassword(password, user.passwordHash)) {
    return user;
  }
  return null;
}

/**
 * Lists users stored in the database
 */
export async function list() {
  // don't return entire users as stored in the database, because
  // we don't want to send password hashes to end users; only
  // return the public fields, as defined above.
  return users.map(user => {
    PUBLIC_FIELDS.reduce((memo, field) => {
      return { ...memo, [field]: user[field] };
    }, {});
  });
}

/**
 * Creates a new user and stores it in the database.
 * @param {string} name the new user's name
 * @param {string} password the new user's password
 */
export async function create(name, password) {
  const newUser = {
    id: `${currentId++}`, // increment the latest id, use it as a string
    name,
    passwordHash: await hashPassword(password)
  };
  users = users.concat(newUser);
}
