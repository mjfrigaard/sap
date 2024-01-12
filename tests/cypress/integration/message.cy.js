// tests/cypress/e2e/message.cy.js

describe("Show message", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("'Show message' button exists", () => {
    cy.get(".message button").should("have.text", "Show message");
  });

  it("'Show message' button shows the message'", () => {
    cy.get(".message button").click();
    cy.get("#app-message-message_text").should("have.text", "This is a message");
   });
});