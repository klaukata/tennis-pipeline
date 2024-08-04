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

    # TODO - test 4 get page source == html
    # TODO - test 4 correctly indentified html emements to click
    # TODO - output of get_page_src == html
    # TODO - output for extract_table == table html


if __name__ == "__main__":
    unittest.main() # allow tests to run using a form: python test_scraper.py
