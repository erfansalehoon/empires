import './globals.css';
import Script from 'next/script';
export const metadata={title:'Empires',description:'بازی استراتژی مدیریت کشور در Telegram Mini App'};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="fa" dir="rtl"><body><Script src="https://telegram.org/js/telegram-web-app.js?57" strategy="beforeInteractive"/>{children}</body></html>}
