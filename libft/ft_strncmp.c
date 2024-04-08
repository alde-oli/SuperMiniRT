/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strncmp.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: alde-oli <alde-oli@student.42lausanne.c    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/10/09 13:22:39 by dvandenb          #+#    #+#             */
/*   Updated: 2023/12/21 09:23:20 by alde-oli         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>

int	ft_strncmp(const char *s1, const char *s2, size_t a)
{
	while (*s1 != '\0' && *s1 == *s2 && a > 0)
	{
		s1++;
		s2++;
		a--;
	}
	if (a == 0)
		return (0);
	return ((unsigned char)*s1 - (unsigned char)*s2);
}
