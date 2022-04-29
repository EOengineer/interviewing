import React, { useState } from 'react'
import {
  Container,
  Form,
  FormGroup,
  Label,
  Input,
  FormFeedback,
  FormText,
  Button
} from 'reactstrap'

export const EditProfileForm = () => {
  const [errors, setErrors] = useState({})
  const [values, setValues] = useState({name: '', email: ''})

  const updateForm = (e) => {
    setValues({...values, [e.target.name]: e.currentTarget.value})
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    // TODO: Patch request to API
  }

  return (
    <Container fluid>
    <h4 className="pt-3 pb-3">Edit Profile</h4>
    <Form onSubmit={(e) => handleSubmit(e)}>
      <FormGroup>
        <Label for="name">
          Name
        </Label>
        <Input name="name" value={values.name} onChange={(e => updateForm(e))} invalid={!!errors.name} />
        <FormFeedback invalid>
          Name Error Here
        </FormFeedback>
        <FormText>
          Bob Smith, Jim, etc...
        </FormText>
      </FormGroup>
      <FormGroup>
        <Label for="email">
          Email
        </Label>
        <Input name="email" value={values.email} onChange={(e => updateForm(e))} invalid={!!errors.email} />
        <FormFeedback invalid>
          Email Errors Here
        </FormFeedback>
        <FormText>
          Example help text that remains unchanged.
        </FormText>
      </FormGroup>
      <FormGroup>
        <Button>Submit</Button>
      </FormGroup>
    </Form>
    </Container>
  )
}
