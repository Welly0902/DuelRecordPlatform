import { Outlet } from 'react-router-dom'
import { useTheme } from '../contexts/ThemeContext'

export default function AppShell() {
  const { theme, toggleTheme } = useTheme()

  return (
    <div className={`min-h-screen flex ${
      theme === 'dark' 
        ? 'bg-[#0a0a0f] text-white' 
        : 'bg-gray-100 text-gray-900'
    }`}>
      {/* ===== 左側 Sidebar ===== */}
      <aside className={`w-[72px] flex flex-col items-center py-5 fixed h-screen ${
        theme === 'dark'
          ? 'bg-[#111118] border-r border-white/10'
          : 'bg-white border-r border-gray-200'
      }`}>
        {/* Logo */}
        <div className="w-10 h-10 rounded-xl bg-indigo-600 flex items-center justify-center font-bold text-lg text-white mb-8">
          D
        </div>

        {/* Nav Icon */}
        <button className={`w-10 h-10 rounded-xl flex items-center justify-center transition-colors ${
          theme === 'dark'
            ? 'bg-white/10 hover:bg-white/20'
            : 'bg-gray-100 hover:bg-gray-200'
        }`}>
          <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
      </aside>

      {/* ===== 主內容區 ===== */}
      <div className="flex-1 ml-[72px] flex flex-col">
        {/* ===== 頂部 Header Bar ===== */}
        <header className={`h-14 flex items-center justify-between px-6 sticky top-0 z-40 ${
          theme === 'dark'
            ? 'bg-[#0a0a0f]/80 backdrop-blur-sm border-b border-white/5'
            : 'bg-gray-100/80 backdrop-blur-sm border-b border-gray-200'
        }`}>
          <div className="text-lg font-semibold">DuelLog</div>
          
          {/* Theme Toggle */}
          <button
            onClick={toggleTheme}
            className={`p-2 rounded-lg transition-colors ${
              theme === 'dark'
                ? 'hover:bg-white/10'
                : 'hover:bg-gray-200'
            }`}
            aria-label="切換主題"
          >
            {theme === 'dark' ? (
              // 太陽 icon (切換到淺色)
              <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
              </svg>
            ) : (
              // 月亮 icon (切換到深色)
              <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
              </svg>
            )}
          </button>
        </header>

        {/* ===== 主內容區 ===== */}
        <main className="flex-1 p-6 max-w-[1800px] mx-auto w-full">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
