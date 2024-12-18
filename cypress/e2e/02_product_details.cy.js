describe("Navigation", () => {
  it("should visit home page", () => {
    cy.visit("/");
  });

  it("There are products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });
  
  it("Click the first product, product detail should be visible", () => {
    cy.visit("/");
    cy.get(".products article").first().click();
    cy.get(".product-detail").should("be.visible");
  });

});