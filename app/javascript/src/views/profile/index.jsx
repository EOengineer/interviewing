import React from 'react'
import { Container, Button } from 'reactstrap'
import { Link } from 'react-router-dom'

export const Index = () => {
  return (
    <Container fluid>
      <h2>Profile Index</h2>
      <Link to='/profile/edit'>Edit</Link>
    </Container>
  )
}
