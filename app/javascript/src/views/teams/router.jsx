import React from 'react'
import { Routes, Route } from 'react-router-dom'

import { TeamsDataProvider } from '../../contexts/teams'

import TeamsIndex from './index'

const Index = () => <TeamsDataProvider><TeamsIndex /></TeamsDataProvider>

const TeamsRouter = () => {
  return (
    <Routes>
      <Route path="/" element={<Index />} />
      <Route path="/:id" element={<div>details page</div>} />
    </Routes>
  )
}

export default TeamsRouter
