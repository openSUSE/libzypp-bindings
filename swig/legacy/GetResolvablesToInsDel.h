/*---------------------------------------------------------------------\
|                          ____ _   __ __ ___                          |
|                         |__  / \ / / . \ . \                         |
|                           / / \ V /|  _/  _/                         |
|                          / /__ | | | | | |                           |
|                         /_____||_| |_| |_|                           |
|                                                                      |
\---------------------------------------------------------------------*/
/** \file	zypp/pool/GetResolvablesToInsDel.h
 *
*/
#ifndef ZYPP_POOL_GETRESOLVABLESTOINSDEL_H
#define ZYPP_POOL_GETRESOLVABLESTOINSDEL_H

#include <iosfwd>
#include <list>

#include <zypp/ResPool.h>
#include <zypp/APIConfig.h>
#include <zypp/sat/Solvable.h>
#include <zypp/sat/Transaction.h>
#include <zypp/pool/PoolStats.h>

///////////////////////////////////////////////////////////////////
namespace zypp
{ /////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////
  namespace pool
  { /////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////
    //
    //	CLASS NAME : GetResolvablesToInsDel
    //
    /** Collect transacting items and sort according to prereqs and
     *  media access.
     *
     * \deprecated Use class \ref sat::Transaction which does a better job
     *             esp. when packages are to be deleted.
     */
    struct ZYPP_DEPRECATED GetResolvablesToInsDel
    {
      typedef std::list<PoolItem> PoolItemList;

      /** Influences the sequence of sources and media proscessed.
       * If true prefer a better source, otherwise a better media.
       * \code
       * ORDER_BY_SOURCE:  [S1:1], [S1:2], ... , [S2:1], [S2:2], ...
       * ORDER_BY_MEDIANR: [S1:1], [S2:1], ... , [S1:2], [S2:2], ...
       * \endcode
       * \deprecated Legacy, no longer supported.
       */
      enum Order { ORDER_BY_SOURCE, ORDER_BY_MEDIANR };

      /** */
      GetResolvablesToInsDel( ResPool pool_r, Order order_r = ORDER_BY_SOURCE )
      {
	sat::Transaction trans( sat::Transaction::loadFromPool );
	trans.order();
	for_( it, trans.actionBegin(~sat::Transaction::STEP_DONE), trans.actionEnd() )
	{
	  switch ( it->stepType() )
	  {
	    case sat::Transaction::TRANSACTION_INSTALL:
	    case sat::Transaction::TRANSACTION_MULTIINSTALL:
	      if ( it->satSolvable().isKind<SrcPackage>() )
		_toSrcinstall.push_back( PoolItem(*it) );
	      else
		_toInstall.push_back( PoolItem(*it) );
	      break;
	    case sat::Transaction::TRANSACTION_ERASE:
	      _toDelete.push_back( PoolItem(*it) );
	      break;
	    case sat::Transaction::TRANSACTION_IGNORE:
	      // NOP
	      break;
	  }
	}
      }

      PoolItemList _toDelete;
      PoolItemList _toInstall;
      PoolItemList _toSrcinstall;
    };
    ///////////////////////////////////////////////////////////////////

    /** \relates GetResolvablesToInsDel Stream output */
    inline std::ostream & operator<<( std::ostream & str, const GetResolvablesToInsDel & obj )
    {
      using std::endl;
      dumpPoolStats( str << "toInstall: " << endl,
		     obj._toInstall.begin(), obj._toInstall.end() ) << endl;
      dumpPoolStats( str << "toDelete: " << endl,
		     obj._toDelete.begin(), obj._toDelete.end() ) << endl;
      return str;
    }

    /////////////////////////////////////////////////////////////////
  } // namespace pool
  ///////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
} // namespace zypp
///////////////////////////////////////////////////////////////////
#endif // ZYPP_POOL_GETRESOLVABLESTOINSDEL_H

