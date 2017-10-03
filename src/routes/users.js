import { route } from "./";
import { create as dbCreate, list as dbList } from "../db/users";

/**
 * Route to create a user. Returns the new user in the payload
 */
export const create = route(
  async (req, res) => {
    const newUser = await dbCreate(req.name, req.password);
    res.send({ data: newUser });
  },
  {
    requiredFields: ["name", "password"]
  }
);

/**
 * Route to list out all users. Returns a list of all users in the payload.
 */
export const list = route(async (req, res) => {
  const users = await usersDb.list();
  res.send({ data: users });
});
