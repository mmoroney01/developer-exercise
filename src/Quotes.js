import React from 'react';

class Quotes extends React.Component {

  constructor() {
  super();
    this.state = {
      quotes: [],
      currentPage: 1,
      quotesPerPage: 15
    };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(e) {
    this.setState({
      currentPage: Number(e.target.id)
    });
  }

  componentDidMount() {
    fetch('https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json')
      .then(results => {
        return results.json();
      }).then(data => {
      this.setState({quotes: data});
      })
  }

  render() {
    const { quotes, currentPage, quotesPerPage } = this.state;

    const firstQuoteOfNextPage = (currentPage * quotesPerPage + 1);

    const indexOfFirstQuote = firstQuoteOfNextPage - quotesPerPage;

    const currentQuotesOnPage = quotes.slice(indexOfFirstQuote, firstQuoteOfNextPage);

    const renderQuotes = currentQuotesOnPage.map((quote, index) => {
        return (
          <tr key={index} >
            <td>{quote.source}</td>
            <td>{quote.context}</td>
            <td>{quote.quote}</td>
            <td>{quote.theme}</td>
          </tr>

        );
      });

    const pageNumbers = [];
    for (let i = 1; i <= Math.ceil(quotes.length / quotesPerPage);
      i++) {
            pageNumbers.push(i);
          }

    const renderPageNumbers = pageNumbers.map(number => {
      return (
        <li
          key={number}
          id={number}
          onClick={this.handleClick}
          >
          {number}
        </li>
        );
    });

    return (
    	<div>
	      <table className="table table-striped table-dark"  style={{"width":"100%"}}>
	        <thead>
	          <tr className="header-row">
	            <th>SOURCE</th>
	            <th>CONTEXT</th>
	            <th>QUOTE</th>
	            <th>THEME</th>
	          </tr>
	        </thead>
	        <tbody className="body-text">
	          { renderQuotes }
	        </tbody>
	      </table>

	      <ul className="d-flex justify-content-center" id="page-numbers">
	         { renderPageNumbers }
	      </ul>
        </div>
    )
  }
}

export default Quotes