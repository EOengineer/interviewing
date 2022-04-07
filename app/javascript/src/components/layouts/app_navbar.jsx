import React, { useState } from 'react';
import {
  Collapse,
  Navbar,
  NavbarToggler,
  NavbarBrand,
  Nav,
  NavItem,
  NavLink,
  UncontrolledDropdown,
  DropdownToggle,
  DropdownMenu,
  DropdownItem } from 'reactstrap';

const AppNavBar = () => {
  const [isOpen, setIsOpen] = useState(false)

    return (
      <div>
        <Navbar color="light" light expand="md">
          <NavbarBrand href="/">MLB Data</NavbarBrand>
          <NavbarToggler onClick={() => setIsOpen(!isOpen)} />
          <Collapse isOpen={isOpen} navbar>
            <Nav className="ml-auto" navbar>
              <NavItem>
                <NavLink href="/teams/">Teams</NavLink>
              </NavItem>
              <NavItem>
                <NavLink href="/players">Players</NavLink>
              </NavItem>
              <UncontrolledDropdown nav inNavbar>
                <DropdownToggle nav caret>
                  Statboards
                </DropdownToggle>
                <DropdownMenu end>
                  <DropdownItem>
                    Career Batting
                  </DropdownItem>
                  <DropdownItem>
                    Season Batting
                  </DropdownItem>
                  <DropdownItem>
                    Career Pitching
                  </DropdownItem>
                  <DropdownItem>
                    Season Pitching
                  </DropdownItem>
                  <DropdownItem>
                    <a href="/users/sign_out" data-method="delete" rel="nofollow">Sign Out</a>
                  </DropdownItem>
                </DropdownMenu>
              </UncontrolledDropdown>
            </Nav>
          </Collapse>
        </Navbar>
      </div>
    );
  // }
}

export default AppNavBar;
