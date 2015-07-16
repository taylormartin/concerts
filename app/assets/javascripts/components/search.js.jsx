var CommentBox = React.createClass({

  getInitialState: function() {
    return {
      cityValue: "i.e. Atlanta",
    };
  },

  handleChange: function(event) {
    this.setState({cityValue: event.target.value});
  },

  handleClick: function() {
    var cityValue = this.state.cityValue;
  },

  render: function() {
    
    var cityValue = this.state.cityValue;

    return (
      <div className="commentBox">
        <label>City Search:</label>
        <input name="search-bar" type="text" onChange={this.handleChange} value={cityValue}></input>
        <button onClick={this.handleClick}>Search</button>
      </div>
    );
  }
});
