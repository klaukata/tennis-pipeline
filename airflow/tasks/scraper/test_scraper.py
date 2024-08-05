import unittest
import scraper

from unittest.mock import MagicMock, patch

class TestScraper(unittest.TestCase):
    def setUp(self):
        self.url = 'https://www.ultimatetennisstatistics.com/goatList'

    @patch('scraper.Options')
    @patch('scraper.Service')
    @patch('scraper.webdriver.Chrome')
    def test_driver_init(self, mock_driver, mock_service, mock_options):
        """
        Tests driver initialization
        """
        options_val = mock_options.return_value
        service_val = mock_service.return_value

        scraper.init_driver()

        mock_driver.assert_called_once_with(
            service = service_val,
            options = options_val
        )

    def test_fetch_website(self):
        """
        Tests:
            1. if a set_window_size() method is called with correct args
            2. if a driver fetches with a correct url
            3. if a func returns a driver
        """
        m_driver = MagicMock()
        
        result = scraper.fetch_website(m_driver)

        result.set_window_size.assert_called_once_with(1980, 1080)
        result.get.assert_called_once_with(self.url)
        self.assertEqual(result, m_driver)
    
    @patch('scraper.By')
    def test_get_page_src(self, mock_by):
        """
        Tests:
            1. Certain html elements were identified
            2. If a func returns drivers page_source 
            3. If driver was disposed of
        """
        m_driver = MagicMock()
        m_driver.page_source = '<html></html>'
        result = scraper.get_page_src(m_driver)
        
        m_driver.find_element.assert_any_call(
            mock_by.CSS_SELECTOR,
            "button.fc-button.fc-cta-consent.fc-primary-button"
        )
        m_driver.find_element.assert_any_call(
            mock_by.CSS_SELECTOR,
            "button.btn.btn-default.dropdown-toggle"
        )
        m_driver.find_element.assert_any_call(
            mock_by.CSS_SELECTOR,
            "ul.dropdown-menu.pull-right > :last-child"
        )
        self.assertEqual(result, '<html></html>')
        m_driver.quit.assert_called_once()

    def test_extract_table(self):
        html = '<html><table></table></html>'
        table = scraper.extract_table(html)
        self.assertEqual(str(table), '<table></table>')
    
    def test_extract_table_none(self):
        html = '<html></html>'
        table = scraper.extract_table(html)
        self.assertIsNone(table)

    # TODO - output for extract_table == table html


if __name__ == "__main__":
    unittest.main() # allow tests to run using a form: python test_scraper.py
