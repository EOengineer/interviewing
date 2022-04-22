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

import { Routes, Route, NavLink } from 'react-router-dom'

import TeamsIndex from '../../views/teams/index'

import { TeamsDataProvider } from '../../contexts/teams'

import { CurrentUserContext } from '../../contexts/current_user'

const Home = () => <div>home</div>

const AllTeams = () => {
  return (
    <TeamsDataProvider>
      <TeamsIndex />
    </TeamsDataProvider>
  )
}

const AppNavBar = () => {
  const [isOpen, setIsOpen] = useState(false)
  const currentUserContext  = useContext(CurrentUserContext)

  return (
    <div>
      <Navbar color="light" light expand="md">
        <NavbarBrand href="/">MLB Data</NavbarBrand>
        <NavbarToggler onClick={() => setIsOpen(!isOpen)} />
        <Collapse isOpen={isOpen} navbar>
          <Nav className="ml-auto" navbar>
          {
            currentUserContext.user &&
            <>
              <NavItem>
                <NavLink to="/teams">Teams</NavLink>
              </NavItem>
              <NavItem>
                <NavLink to="/players">Players</NavLink>
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
                <NavItem>
                  <NavLink to="/users/sign_out">Sign Out</NavLink>
                </NavItem>
              </>
            }
            {
              !currentUserContext.user &&
              <>
                <NavItem>
                  <NavLink to="/users/sign_up">Register</NavLink>
                </NavItem>
                <NavItem>
                  <NavLink to="/users/sign_in">Sign In</NavLink>
                </NavItem>
              </>
            }
          </Nav>
        </Collapse>
      </Navbar>

        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/teams" element={<AllTeams/>} />
        </Routes>
    </div>
  );
}

export default AppNavBar;
