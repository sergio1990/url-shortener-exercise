import config from 'config';
import axios from 'axios';

const ALL_LINKS_FULL_URL = `${config.SHORTENER_API_BASE_URL}urls`;
const SHORTEN_LINK_FULL_URL = ALL_LINKS_FULL_URL;

class ShortenerAPI {
  async allLinks() {
    const response = await axios.get(ALL_LINKS_FULL_URL);
    return response.data;
  }

  async shortenLink(url) {
    const data = { url: url };
    const headers = { 'Content-Type': 'application/json' };
    const response = await axios.post(SHORTEN_LINK_FULL_URL, data, { headers });
    return response.data;
  }
}

const defaultShortenerAPIClient = new ShortenerAPI();

export default defaultShortenerAPIClient;
