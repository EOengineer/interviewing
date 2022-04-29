import React from 'react'
import { Routes, Route } from 'react-router-dom'

import { TeamsDataProvider } from '../../contexts/teams'

import { Index } from './index'
import { EditProfileForm } from './edit'

const ProfileRouter = () => {
  return (
    <Routes>
      <Route path="/" element={<Index />} />
      <Route path="/:edit" element={<EditProfileForm />} />
    </Routes>
  )
}

export default ProfileRouter
