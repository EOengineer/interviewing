import React, { useState, useContext } from 'react';
import {
  Collapse,
  Navbar,
  NavbarToggler,
  NavbarBrand,
  Nav,
  NavItem,
  UncontrolledDropdown,
  DropdownToggle,
  DropdownMenu,
  DropdownItem } from 'reactstrap';

import { Routes, Route, NavLink, Link } from 'react-router-dom'

// routers
import TeamsRouter from '../../views/teams/router'
import ProfileRouter from '../../views/profile/router'

// contexts
import { CurrentUserContext } from '../../contexts/current_user'

const Home = () => <div>home</div>

const AppNavBar = () => {
  const [isOpen, setIsOpen] = useState(false)
  const currentUserContext  = useContext(CurrentUserContext)

  return (
    <div>
      <Navbar color="light" light expand="md">
        <Link className="navbar-brand" to="/">MLB Data</Link>
        <NavbarToggler onClick={() => setIsOpen(!isOpen)} />
        <Collapse isOpen={isOpen} navbar>
          <Nav className="ml-auto" navbar>
          {
            currentUserContext.user &&
            <>
              <NavItem>
                <NavLink className="nav-link" to="/teams">Teams</NavLink>
              </NavItem>
              <NavItem>
                <NavLink className="nav-link" to="/players">Players</NavLink>
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
                  </DropdownMenu>
                </UncontrolledDropdown>
                <UncontrolledDropdown nav inNavbar>
                  <DropdownToggle nav caret>
                    My Stuff
                  </DropdownToggle>
                  <DropdownMenu end>
                    <DropdownItem>
                      Add A Team
                    </DropdownItem>
                    <DropdownItem>
                      Add A Player
                    </DropdownItem>
                    <DropdownItem>
                      <NavLink className="nav-link" to="/profile">Profile</NavLink>
                    </DropdownItem>
                    <DropdownItem>
                      <a href="/users/sign_out" data-method="delete" rel="nofollow">Sign Out</a>
                    </DropdownItem>
                  </DropdownMenu>
                </UncontrolledDropdown>
              </>
            }
            {
              !currentUserContext.user &&
              <>
                <NavItem>
                  <a className="nav-link" href="/users/sign_up">Register</a>
                </NavItem>
                <NavItem>
                  <a className="nav-link" href="/users/sign_in">Sign In</a>
                </NavItem>
              </>
            }
          </Nav>
        </Collapse>
      </Navbar>

        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/teams/*" element={<TeamsRouter/>} />
          <Route path="/profile/*" element={<ProfileRouter/>} />
        </Routes>
    </div>
  );
}

export default AppNavBar;
