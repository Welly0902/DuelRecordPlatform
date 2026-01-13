import { useState, useEffect } from 'react'
import './App.css'

interface HealthResponse {
  ok: boolean
  message: string
  db: string
}

function App() {
  const [health, setHealth] = useState<HealthResponse | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const checkHealth = async () => {
      try {
        const apiUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080'
        const response = await fetch(`${apiUrl}/health`)
        
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        
        const data = await response.json()
        setHealth(data)
        setError(null)
      } catch (err) {
        setError(err instanceof Error ? err.message : '無法連接到 API')
        setHealth(null)
      } finally {
        setLoading(false)
      }
    }

    checkHealth()
  }, [])

  return (
    <div style={{ 
      minHeight: '100vh', 
      display: 'flex', 
      flexDirection: 'column',
      alignItems: 'center', 
      justifyContent: 'center',
      padding: '2rem'
    }}>
      <h1 style={{ fontSize: '3rem', marginBottom: '2rem' }}>
        🎮 DuelLog Platform
      </h1>
      
      <div style={{
        padding: '2rem',
        borderRadius: '8px',
        backgroundColor: '#1a1a1a',
        minWidth: '400px',
        textAlign: 'center'
      }}>
        <h2 style={{ marginBottom: '1rem' }}>Phase 0: 系統狀態</h2>
        
        {loading && <p>🔄 檢查中...</p>}
        
        {error && (
          <div style={{ color: '#ff6b6b' }}>
            <p>❌ API 連線失敗</p>
            <p style={{ fontSize: '0.9rem', marginTop: '0.5rem' }}>{error}</p>
            <p style={{ fontSize: '0.8rem', marginTop: '1rem', color: '#888' }}>
              請確認後端是否已啟動在 http://localhost:8080
            </p>
          </div>
        )}
        
        {health && (
          <div style={{ color: '#51cf66' }}>
            <p style={{ fontSize: '2rem' }}>✅</p>
            <p style={{ fontSize: '1.2rem', fontWeight: 'bold' }}>
              API 連線正常
            </p>
            <div style={{ marginTop: '1rem', fontSize: '0.9rem', color: '#aaa' }}>
              <p>狀態: {health.ok ? '正常' : '異常'}</p>
              <p>訊息: {health.message}</p>
              <p>資料庫: {health.db}</p>
            </div>
          </div>
        )}
      </div>

      <p style={{ marginTop: '2rem', color: '#888', fontSize: '0.9rem' }}>
        前端運行於 {window.location.origin}
      </p>
    </div>
  )
}

export default App
