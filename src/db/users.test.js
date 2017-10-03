import { UsersDB } from "./users";

describe("create", () => {
  test("Increments the id when multiple users are added", async () => {
    const db = new UsersDB();
    const user1 = await db.create("User 0", "my password");
    const user2 = await db.create("User 1", "my other password");
    expect(user1.id).toBe("0");
    expect(user2.id).toBe("1");
  });
});

describe("list", () => {
  test("lists no users when none have been added", async () => {
    const db = new UsersDB();
    expect(await db.list()).toHaveLength(0);
  });
});
