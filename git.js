// http://aboutcode.net/2010/11/11/list-github-projects-using-javascript.html

jQuery.githubUser = function(username, callback) {
  jQuery.getJSON("https://api.github.com/users/" + username + "/repos", callback);
}

jQuery.fn.loadRepositories = function(username) {
  this.html("<span>Querying GitHub for " + username +"'s repositories...</span>");

  var target = this;
  $.githubUser(username, function(data) {

    var repos = data.data; 
    // sortByNumberOfWatchers(repos);
    // console.log(data); 

    var list = $('<dl/>');
    var nom = ""; 
    var description = "";
    // console.log("coucou");
    target.empty().append(list);
    $(data).each(function(i, val) {
      $.each(val,function(k,v){
        if (k == "name") {
          nom = v;
        }
        if (k == "description") {
          description = v;
        }
        if (k == "clone_url") {
          // console.log(nom + " : " + v);
          list.append('<dt><a href="'+ v +'">' + nom + '</a></dt>');
          list.append('<dd>' + description + '</dd>');
        }
      });
    }); 

  });

  function sortByNumberOfWatchers(repos) {
    repos.sort(function(a,b) {
      return b.watchers - a.watchers;
    });
  }
};