import { rules } from "../../app/javascript/utils";

describe("Form Rules", () => {
  describe("requiered", () => {
    it("empty input return a string", () => {
      expect(typeof rules.required("")).toBe("string");
    });

    it("not empty input return true", () => {
      expect(rules.required("not empty")).toBeTruthy();
    });
  });

  describe("email", () => {
    it("must contain @", () => {
      expect(typeof rules.email("michael.example.com")).toBe("string");
    });

    it("@ cant be at the beginning", () => {
      expect(typeof rules.email("@michael.example.com")).toBe("string");
    });

    it("must contain a domain of atleast length 2", () => {
      expect(typeof rules.email("michael@example.c")).toBe("string");
    });

    it("must contain characters before the dot in doamin", () => {
      expect(typeof rules.email("michael@.com")).toBe("string");
    });
  });
});
