import config from 'config';
import axios from 'axios';

const ALL_LINKS_FULL_URL = `${config.SHORTENER_API_BASE_URL}urls`;
const SHORTEN_LINK_FULL_URL = ALL_LINKS_FULL_URL;

class ShortenerAPI {
  async allLinks() {
    const response = await axios.get(ALL_LINKS_FULL_URL);
    return response.data;
  }
}

const defaultShortenerAPIClient = new ShortenerAPI();

export default defaultShortenerAPIClient;
