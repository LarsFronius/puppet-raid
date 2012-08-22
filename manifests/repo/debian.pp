class raid::repo::debian {
  apt::source { 'raid':
    location    => 'http://hwraid.le-vert.net/debian',
    release     => $::lsbdistcodename,
    repos       => 'main',
  }

  #FIXME the repo sucks a bit http://hwraid.le-vert.net/ticket/12
  apt::conf { 'unauthenticated':
    priority => '99',
    content  => 'APT::Get::AllowUnauthenticated yes;'
  }
}
