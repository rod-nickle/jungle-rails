describe("Navigation", () => {
  it("should visit home page", () => {
    cy.visit("/");
  });

  it("There are products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });
  
  it("Click Add to Cart for the first product, the cart count should increase from 0 to 1", () => {
    cy.visit("/");
    cy.contains('My Cart (0)');
    cy.get(".products article").first().contains('Add').click({force:true});
    cy.contains('My Cart (1)');
  });

});