import { useState } from 'react';
import { Shield, Sparkles } from 'lucide-react';
import InputTypeSelector from './components/InputTypeSelector';
import TextInput from './components/TextInput';
import FileUpload from './components/FileUpload';
import URLInput from './components/URLInput';
import AnalysisResult from './components/AnalysisResult';
import Hero from './components/Hero';
import Features from './components/Features';
import LanguageSelector from './components/LanguageSelector';
import NotificationCenter from './components/NotificationCenter';
import NotificationPost from './components/NotificationPost';
import { useLanguage } from './contexts/LanguageContext';
import { analyzeText, analyzeMedia, analyzeURL } from './services/analysisService';
import { createNotification, determineVerdict } from './services/notificationService';

type InputType = 'text' | 'media' | 'url' | 'notification' | null;

interface AnalysisData {
  authenticityScore: number;
  isAuthentic: boolean;
  isWarning: boolean;
  detectionMetrics: Array<{
    label: string;
    score: number;
  }>;
  findings: string[];
  recommendation: string;
  analysisTime: string;
  content?: string;
  file?: File;
  factCheck?: {
    claim: string;
    verdict: string;
    explanation: string;
    correctedStatement?: string;
    sources: Array<{
      name: string;
      url: string;
      credibility: string;
    }>;
  };
}

function App() {
  const { t } = useLanguage();
  const [selectedType, setSelectedType] = useState<InputType>(null);
  const [analyzing, setAnalyzing] = useState(false);
  const [analysisData, setAnalysisData] = useState<AnalysisData | null>(null);

  const handleSelectType = (type: 'text' | 'media' | 'url' | 'notification') => {
    setSelectedType(type);
  };

  const handleNotificationAnalysis = async (notificationText: string, source: string) => {
    setAnalyzing(true);
    setAnalysisData(null);

    try {
      const result = await analyzeText(`[${source.toUpperCase()} Message] ${notificationText}`);
      setAnalysisData({ ...result, content: notificationText });

      await createNotification({
        content: `[${source}] ${notificationText.substring(0, 450)}`,
        content_type: 'text',
        verdict: determineVerdict(result.authenticityScore),
        authenticity_score: result.authenticityScore,
        reasoning: result.recommendation,
        key_findings: result.findings,
        corrected_statement: result.factCheck?.correctedStatement,
        sources: result.factCheck?.sources || [],
      });
    } catch (error) {
      console.error('Analysis error:', error);
      alert('Failed to analyze notification. Please try again.');
    } finally {
      setAnalyzing(false);
    }
  };

  const handleTextAnalysis = async (text: string) => {
    setAnalyzing(true);
    setAnalysisData(null);

    try {
      const result = await analyzeText(text);
      setAnalysisData({ ...result, content: text });

      await createNotification({
        content: text.substring(0, 500),
        content_type: 'text',
        verdict: determineVerdict(result.authenticityScore),
        authenticity_score: result.authenticityScore,
        reasoning: result.recommendation,
        key_findings: result.findings,
        corrected_statement: result.factCheck?.correctedStatement,
        sources: result.factCheck?.sources || [],
      });
    } catch (error) {
      console.error('Analysis error:', error);
      alert('Failed to analyze text. Please try again.');
    } finally {
      setAnalyzing(false);
    }
  };

  const handleFileUpload = async (file: File) => {
    setAnalyzing(true);
    setAnalysisData(null);

    try {
      const result = await analyzeMedia(file);
      setAnalysisData({ ...result, file });

      await createNotification({
        content: `${file.name} (${file.type})`,
        content_type: 'media',
        verdict: determineVerdict(result.authenticityScore),
        authenticity_score: result.authenticityScore,
        reasoning: result.recommendation,
        key_findings: result.findings,
        corrected_statement: result.factCheck?.correctedStatement,
        sources: result.factCheck?.sources || [],
      });
    } catch (error) {
      console.error('Analysis error:', error);
      alert('Failed to analyze media. Please try again.');
    } finally {
      setAnalyzing(false);
    }
  };

  const handleURLAnalysis = async (url: string) => {
    setAnalyzing(true);
    setAnalysisData(null);

    try {
      const result = await analyzeURL(url);
      setAnalysisData({ ...result, content: url });

      await createNotification({
        content: url.substring(0, 500),
        content_type: 'url',
        verdict: determineVerdict(result.authenticityScore),
        authenticity_score: result.authenticityScore,
        reasoning: result.recommendation,
        key_findings: result.findings,
        corrected_statement: result.factCheck?.correctedStatement,
        sources: result.factCheck?.sources || [],
      });
    } catch (error) {
      console.error('Analysis error:', error);
      alert('Failed to analyze URL. Please try again.');
    } finally {
      setAnalyzing(false);
    }
  };

  const handleReset = () => {
    setSelectedType(null);
    setAnalyzing(false);
    setAnalysisData(null);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900">
      <nav className="bg-slate-900/50 backdrop-blur-md border-b border-slate-700/50 sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <Shield className="w-8 h-8 text-cyan-400" />
              <div>
                <h1 className="text-2xl font-bold text-white">{t('appName')}</h1>
                <p className="text-xs text-cyan-400">{t('tagline')}</p>
              </div>
            </div>
            <div className="flex items-center space-x-3">
              <NotificationCenter />
              <LanguageSelector />
              <button
                onClick={handleReset}
                className="px-4 py-2 bg-slate-700/50 hover:bg-slate-700 text-white rounded-lg transition-all duration-200 text-sm font-medium"
              >
                {t('newAnalysis')}
              </button>
            </div>
          </div>
        </div>
      </nav>

      <main>
        {!selectedType && !analysisData && (
          <>
            <Hero />
            <InputTypeSelector onSelectType={handleSelectType} />
            <Features />
          </>
        )}

        {selectedType === 'text' && !analysisData && !analyzing && (
          <TextInput onAnalyze={handleTextAnalysis} />
        )}

        {selectedType === 'notification' && !analysisData && !analyzing && (
          <NotificationPost onAnalyze={handleNotificationAnalysis} analyzing={analyzing} />
        )}

        {selectedType === 'media' && !analysisData && !analyzing && (
          <section className="py-16 px-4">
            <div className="max-w-3xl mx-auto">
              <div className="text-center mb-8">
                <h2 className="text-3xl font-bold text-white mb-4">Upload Media for Analysis</h2>
                <p className="text-slate-300">Select an image, video, or audio file to verify its authenticity</p>
              </div>
              <FileUpload onFileUpload={handleFileUpload} />
            </div>
          </section>
        )}

        {selectedType === 'url' && !analysisData && !analyzing && (
          <URLInput onAnalyze={handleURLAnalysis} isAnalyzing={analyzing} />
        )}

        {analyzing && (
          <section className="py-16 px-4">
            <div className="max-w-5xl mx-auto">
              <div className="bg-slate-800/50 backdrop-blur-md rounded-2xl p-12 border border-slate-700/50 text-center">
                <div className="flex justify-center mb-6">
                  <div className="relative">
                    <Sparkles className="w-16 h-16 text-cyan-400 animate-pulse" />
                    <div className="absolute inset-0 bg-cyan-400/20 rounded-full blur-xl animate-pulse"></div>
                  </div>
                </div>
                <h3 className="text-2xl font-bold text-white mb-4">
                  {selectedType === 'text' ? t('analyzingText') : selectedType === 'url' ? 'Analyzing URL...' : t('analyzingMedia')}
                </h3>
                <p className="text-slate-300 mb-6">{t('runningAlgorithms')}</p>
                <div className="max-w-md mx-auto bg-slate-700/50 rounded-full h-2 overflow-hidden">
                  <div className="bg-gradient-to-r from-cyan-400 to-blue-500 h-full rounded-full animate-[progress_3s_ease-in-out]" style={{width: '100%'}}></div>
                </div>
              </div>
            </div>
          </section>
        )}

        {analysisData && (
          <section className="py-16 px-4">
            <div className="max-w-5xl mx-auto">
              <AnalysisResult
                data={analysisData}
                type={selectedType === 'notification' || selectedType === 'url' ? 'text' : selectedType || 'media'}
                onReset={handleReset}
              />
            </div>
          </section>
        )}
      </main>

      <footer className="bg-slate-900/50 backdrop-blur-md border-t border-slate-700/50 py-8 mt-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-slate-400">
          <p>&copy; 2025 {t('appName')}. {t('footer')}</p>
        </div>
      </footer>
    </div>
  );
}

export default App;
