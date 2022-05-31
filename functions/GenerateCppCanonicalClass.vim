" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    GenerateCppCanonicalClass.vim                      :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: tsiguenz <tsiguenz@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/05/22 02:19:49 by tsiguenz          #+#    #+#              "
"    Updated: 2022/05/31 15:48:25 by tsiguenz         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"C++ Canonical Class Generator

function! Class(ClassName)

"==================  Header file =====================

	execute 'vsp src/'.a:ClassName.'.hpp'
	execute 'normal! i#ifndef '.toupper(a:ClassName).'_HPP'
	execute 'normal! o# define '.toupper(a:ClassName).'_HPP'
	execute 'normal! o'
	execute 'normal! o# include <iostream>'
	execute 'normal! o'
	execute 'normal! oclass '.a:ClassName.' {'
	execute 'normal! o'
	execute 'normal! opublic:'
	execute 'normal! o	'.a:ClassName.'(void);'
	execute 'normal! o	'.a:ClassName.'('.a:ClassName.' const& '.tolower(a:ClassName).');'
	execute 'normal! o	virtual ~'.a:ClassName.'(void);'
	execute 'normal! o	'.a:ClassName.'& operator=('.a:ClassName.' const& '.tolower(a:ClassName).');'
	execute 'normal! o'
	execute 'normal! oprivate:'
	execute 'normal! o'
	execute 'normal! o};'
	execute 'normal! o'
	execute 'normal! o#endif // '.toupper(a:ClassName).'_HPP'
	execute 'Stdheader'
	execute 'w'

"================== Source file ========================

	execute 'sp src/'.a:ClassName.'.cpp'
	execute 'normal! i#include "'.a:ClassName.'.hpp"'
	execute 'normal! o'
	execute 'normal! o'.a:ClassName.'::'.a:ClassName.'(void) {'
	execute 'normal! o	return ;'
	execute 'normal! o}'
	execute 'normal! o'
	execute 'normal! o'.a:ClassName.'::'.a:ClassName.'('.a:ClassName.' const& '.tolower(a:ClassName).') {'
	execute 'normal! o	*this = '.tolower(a:ClassName).';'
	execute 'normal! o	return ;'
	execute 'normal! o}'
	execute 'normal! o'
	execute 'normal! o'.a:ClassName.'::~'.a:ClassName.'(void) {'
	execute 'normal! o	return ;'
	execute 'normal! o}'
	execute 'normal! o'
	execute 'normal! o'.a:ClassName.'&	'.a:ClassName.'::operator=('.a:ClassName.' const& '.tolower(a:ClassName).') {'
	execute 'normal! o	return *this;'
	execute 'normal! o}'
	execute 'Stdheader'
	execute 'w'
endfunction
