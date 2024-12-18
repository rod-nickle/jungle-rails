describe("Navigation", () => {
  it("should visit home page", () => {
    cy.visit("/");
  });

  it("There are products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });

});
