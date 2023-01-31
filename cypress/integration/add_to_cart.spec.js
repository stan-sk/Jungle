describe('Home Page', () => {

  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get("article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get("article").should("have.length", 2);
  });

  it("should navigate to product detail page", () => {
    
    cy.get(":nth-child(1) > a > img")
      .click()
  });

  it("Add to Cart' button for a product on the home page and in doing so their cart increases by one", () => {
    
    cy.get(":nth-child(1) > div > .button_to > .btn")
      .click({force: true})
    cy.get("#navbarSupportedContent > :nth-child(2) > :nth-child(3) > .nav-link").should("contain", "My Cart (1)")
  });
})