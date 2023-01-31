describe('Home Page', () => {

  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('/')
  })


  it("users can login successfully and are taken to the home page once they are signed in", () => {
    
    cy.get("#navbarSupportedContent > :nth-child(2) > :nth-child(2) > .nav-link")
      .click()
    cy.get("#email").type("yoshi123@gmail.com")
    cy.get('#password').type("AA123456")
    cy.get('form.login-form')
      .submit()
    cy.get("#navbarSupportedContent > :nth-child(2) > :nth-child(2) > .nav-link").should("contain", "Logout")
    cy.getCookie("_new_session").should('exist')
  });
})