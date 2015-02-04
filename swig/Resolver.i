#ifdef SWIGPERL5
   %template(StringList) std::list<std::string>;
#endif

%include <zypp/ProblemTypes.h>
%include <zypp/ResolverProblem.h>
%include <zypp/ProblemSolution.h>
%include <zypp/Resolver.h>

/* ResPoool provides leagacy GetResolvablesToInsDel */
%ignore zypp::Resolver::getTransaction();


typedef std::list<zypp::ProblemSolution_Ptr> ProblemSolutionList;
%template(ProblemSolutionList) std::list<zypp::ProblemSolution_Ptr>;

typedef boost::intrusive_ptr< zypp::ProblemSolution > ProblemSolution_Ptr;
%template(ProblemSolution_Ptr) boost::intrusive_ptr< zypp::ProblemSolution >;


typedef std::list< zypp::solver::detail::SolutionAction_constPtr > CSolutionActionList;
%template(CSolutionActionList) std::list< zypp::solver::detail::SolutionAction_constPtr >;

namespace zypp
{

  typedef ::zypp::intrusive_ptr< Resolver > Resolver_Ptr;
  %template(Resolver_Ptr) ::zypp::intrusive_ptr<Resolver>;

#ifndef SWIGRUBY
  /* swig generates wrong code (>> instead of > > for template type)
   * in Ruby
   */

  typedef ::boost::intrusive_ptr< ResolverProblem > ResolverProblem_Ptr;
  %template(ResolverProblem_Ptr) ::boost::intrusive_ptr< ResolverProblem >;
  typedef std::list< ResolverProblem_Ptr > ResolverProblemList;
  %template(ResolverProblemList) ::std::list< ResolverProblem_Ptr >;

#endif
}


