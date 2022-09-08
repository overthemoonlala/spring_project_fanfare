package sitemesh;

import javax.servlet.annotation.WebFilter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

@WebFilter("/*")
public class SiteMeshFilter extends ConfigurableSiteMeshFilter{
	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("/*", "/layout/layout.jsp")
		.addExcludedPath("/user/deleteForm*")
		.addExcludedPath("/user/deleteWishForm*")
		.addExcludedPath("/board/imgupload*")
		.addExcludedPath("/user/idsearch*")
		.addExcludedPath("/user/pwsearch*")
		.addExcludedPath("/bakery/bakerydetail**");
	}
}
