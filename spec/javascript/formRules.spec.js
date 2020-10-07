import { rules } from "../../app/javascript/utils";

describe("Form Rules", () => {
  describe("requiered", () => {
    it("empty input return a string", () => {
      expect(rules.requied("")).toBeInstanceOf(String);
    });
  });
});
